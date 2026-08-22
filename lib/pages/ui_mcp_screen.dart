import 'package:material_ui/material_ui.dart';

class UiMcpScreen extends StatefulWidget {
  const UiMcpScreen({super.key});

  @override
  State<UiMcpScreen> createState() => _UiMcpScreenState();
}

class _UiMcpScreenState extends State<UiMcpScreen> {
  final _searchController = TextEditingController();
  bool _isSearchFocused = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() => _isSearchFocused = false);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFAF8FF),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 0, bottom: 88),
                  children: [
                    _buildTopAppBar(),
                    _buildSearchBar(),
                    const SizedBox(height: 24),
                    _buildFeaturedCategories(),
                    const SizedBox(height: 24),
                    _buildRecommendations(),
                    const SizedBox(height: 24),
                    _buildQuoteSection(),
                  ],
                ),
              ),
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: const Color(0xFFFAF8FF),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEAEDFF),
              border: Border.all(
                color: const Color(0xFFC7C5D4).withValues(alpha: 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBdXDghMfpB6e7kYwA0IK0lv32LItCEKpne8-gaSBqdAPoVv4aI2r1XOveTvoeraNvQKEh21YVsqeAUTkCZVtSKmahMh6DrzcgFX2Mp7A83x8NYe9_JiQfgqd5w5_KqsUqJLjQagCrglbZDoTg2K8Jb7QVN49BGgppJFR_GdBAIz1UFUgfijiqjYeVRzj0ixi5dR_uh6QNSFqL1i3szdcnMx3aI3iIAV-6pG9EYZHz_fVuzUTyZxxHLQQ',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Color(0xFF2E3192)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'Welcome back',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 28,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.01,
              color: const Color(0xFF15157D),
              height: 34 / 28,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF15157D)),
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedScale(
        scale: _isSearchFocused ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isSearchFocused
                  ? const Color(0xFF2E3192)
                  : const Color(0xFFC7C5D4).withValues(alpha: 0.2),
              width: _isSearchFocused ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onTap: () => setState(() => _isSearchFocused = true),
            onSubmitted: (_) => setState(() => _isSearchFocused = false),
            onEditingComplete: () => setState(() => _isSearchFocused = false),
            decoration: InputDecoration(
              hintText: 'Search for anything...',
              hintStyle: TextStyle(
                color: const Color(0xFF777683).withValues(alpha: 0.6),
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF777683)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FEATURED CATEGORIES',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.05,
                  color: const Color(0xFF131B2E),
                  height: 20 / 14,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF15157D),
                    height: 16 / 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 192,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _buildCategoryCard(
                icon: Icons.payments,
                label: 'Finance',
                subtitle: 'Manage assets',
                bgColor: const Color(0xFF2E3192),
                iconColor: const Color(0xFF9DA1FF),
                textColor: const Color(0xFF9DA1FF),
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                icon: Icons.local_cafe,
                label: 'Lifestyle',
                subtitle: 'Daily goals',
                bgColor: const Color(0xFFDAE2FD),
                iconColor: const Color(0xFF15157D),
                textColor: const Color(0xFF131B2E),
                border: Border.all(
                  color: const Color(0xFFC7C5D4).withValues(alpha: 0.1),
                ),
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                icon: Icons.devices,
                label: 'Tech',
                subtitle: 'New gadgets',
                bgColor: const Color(0xFF283044),
                iconColor: const Color(0xFFEEF0FF),
                textColor: const Color(0xFFEEF0FF),
              ),
              const SizedBox(width: 16),
              _buildCategoryCard(
                icon: Icons.favorite,
                label: 'Health',
                subtitle: 'Vital stats',
                bgColor: const Color(0xFFD0E1FB),
                iconColor: const Color(0xFF54647A),
                textColor: const Color(0xFF54647A),
                border: Border.all(
                  color: const Color(0xFFC7C5D4).withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color bgColor,
    required Color iconColor,
    required Color textColor,
    Border? border,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 160,
        height: 192,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow: bgColor == const Color(0xFF2E3192)
              ? [
                  BoxShadow(
                    color: const Color(0xFF2E3192).withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: iconColor, size: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    height: 24 / 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor.withValues(alpha: 0.7),
                    height: 16 / 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECOMMENDATIONS',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              color: const Color(0xFF131B2E),
              height: 20 / 14,
            ),
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            icon: Icons.trending_up,
            title: 'Weekly Overview',
            subtitle: 'Your productivity increased by 12%.',
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            icon: Icons.lightbulb,
            title: 'Smart Tip',
            subtitle: 'Try the new focus mode for deep work.',
          ),
          const SizedBox(height: 16),
          _buildRecommendationItem(
            icon: Icons.update,
            title: 'System Update',
            subtitle: 'New performance features are live.',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFC7C5D4).withValues(alpha: 0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E3192).withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAEDFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF15157D)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF131B2E),
                      height: 24 / 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF464652),
                      height: 20 / 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: const Color(0xFFC7C5D4)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: const DecorationImage(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDsjWRX9GtVrkV_qBEW_lAp8t7TsfgCjozStbhg5108uucn1GwRmZYCM35XUNNS7bnAp-rvmZKAp2PqvdJ-qcQpYfIGSCBrWSiG69wPqnbcoNig5bLlA5RjAOtGRF9Ff4d6UKMMr0Sb_xDCe-JRAy9aFtmUaH9Gidf4BLA7LzwecJN3VVrVhTV7LfxkrwIeLjYvmWGbdWrfrE9UW4aLCCYOk3KdCdua6TEdHctizP8ZM2Vr0iAxXRYpJg',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF2E3192).withValues(alpha: 0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DAILY INSIGHT',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 16 / 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"Clarity precedes mastery."',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    height: 28 / 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF8FF),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E3192).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, isActive: true),
            _buildNavItem(Icons.search),
            _buildNavItem(Icons.notifications),
            _buildNavItem(Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2E3192) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? const Color(0xFF9DA1FF) : const Color(0xFF505F76),
        size: 24,
      ),
    );
  }
}
