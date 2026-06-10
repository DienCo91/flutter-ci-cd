package com.example.batterylevel

import NetWorkStatus
import NetworkApi
import RamApi
import RamResult
import SearchApi
import SearchReply
import SearchRequest
import android.annotation.SuppressLint
import android.app.ActivityManager
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.BatteryManager
import android.os.Build
import android.os.Process
import android.telephony.TelephonyManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MySearchHandler : SearchApi {

    override fun search(request: SearchRequest): SearchReply {

        val result = "Search result for query: ${request.query}"

        return SearchReply(result)
    }

}

class RamStatus(val context: Context, val pinStatus: Int) : RamApi {
    override fun getRamInfo(): RamResult {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

        // 1. Khởi tạo đối tượng chứa dữ liệu
        val memInfo = ActivityManager.MemoryInfo()

        // CỰC KỲ QUAN TRỌNG: Phải gọi hàm này để lấy dữ liệu từ hệ thống
        activityManager.getMemoryInfo(memInfo)

        // 2. Tính toán RAM Hệ thống (Dùng Double để chia cho chính xác)
        val totalRam = memInfo.totalMem.toDouble() / (1024 * 1024)
        val ramFree = memInfo.availMem.toDouble() / (1024 * 1024)

        // 3. Lấy thông tin RAM App đang sử dụng
        val pid = Process.myPid()
        val processMemoryInfo = activityManager.getProcessMemoryInfo(intArrayOf(pid))[0]

        // totalPss tính bằng KB, chia 1024 để ra MB
        val ramUsed = processMemoryInfo.totalPss.toDouble() / 1024

        //temperature
        val intent = context.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

        val tempInt = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) ?: 0
        val temperature = tempInt.toDouble() / 10

        // Trả về kết quả cho Flutter qua Pigeon
        return RamResult(
            ramUsed = ramUsed,
            ramTotal = totalRam,
            ramFree = ramFree,
            pinStatus = pinStatus.toLong(),
            tempStatus = temperature.toLong()
        )
    }
}


class NetWork(val context: Context) : NetworkApi {
    override fun getNetworkInfo(): NetWorkStatus {
        val connectivityManager =
            context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val network = connectivityManager.activeNetwork
        val capabilities = connectivityManager.getNetworkCapabilities(network)

        // 1. Xác định loại kết nối
        val connectionType = when {
            capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) == true -> "WIFI"
            capabilities?.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) == true -> "MOBILE"
            else -> "NONE"
        }

        // 2. Phân loại tốc độ
        val downSpeed = capabilities?.linkDownstreamBandwidthKbps ?: 0
        val speed = when {
            downSpeed >= 30000 -> "High"
            downSpeed >= 5000 -> "Medium"
            else -> "Low"
        }

        // 3. Lấy tên nhà mạng (Chỉ khi dùng Mobile Data)
        var carrierName = "N/A"
        if (connectionType == "MOBILE") {
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
            val name = telephonyManager.networkOperatorName
            if (!name.isNullOrEmpty()) {
                carrierName = name
            }
        }

        return NetWorkStatus(
            name = if (connectionType == "WIFI") "Wifi Connection" else carrierName,
            speed = speed,
            carrierName = carrierName,
            connectionType = connectionType
        )
    }
}

class MainActivity : FlutterActivity() {

    private val CHANNEL = "sample.flutter.dev/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //MethodChannel
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "getBatteryLevel" -> {
                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }

        val pinStatus = getBatteryLevel();
        //pigeon
        SearchApi.setUp(flutterEngine.dartExecutor.binaryMessenger, MySearchHandler())
        RamApi.setUp(flutterEngine.dartExecutor.binaryMessenger, RamStatus(this, pinStatus))
        NetworkApi.setUp(flutterEngine.dartExecutor.binaryMessenger, NetWork(this))
    }

    @SuppressLint("ObsoleteSdkInt")
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
        }
        return batteryLevel
    }
}
