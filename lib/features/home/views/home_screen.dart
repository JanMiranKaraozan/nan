import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_sizes.dart';
import '../providers/home_provider.dart';
import '../widgets/home_header.dart';
import '../widgets/category_list.dart';
import '../widgets/popular_section.dart';
import '../widgets/food_grid.dart';
import '../widgets/search_bar_widget.dart';

/// Ana sayfa ekranı.
/// Header, arama, kategoriler, popüler yemekler ve tüm yemekler bölümlerini içerir.
class HomeScreen extends StatefulWidget {
  final VoidCallback onCartTap;

  const HomeScreen({super.key, required this.onCartTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return SafeArea(
          child: CustomScrollView(
            slivers: [
              // ── Arama modu veya normal header ──────────────────
              SliverToBoxAdapter(
                child: homeProvider.isSearching
                    ? SearchBarWidget(
                        controller: _searchController,
                        onChanged: homeProvider.updateSearchQuery,
                        onClose: () {
                          _searchController.clear();
                          homeProvider.closeSearch();
                        },
                      )
                    : HomeHeader(
                        onCartTap: widget.onCartTap,
                        onSearchTap: homeProvider.toggleSearch,
                      ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.paddingLG),
              ),

              // ── Kategoriler ───────────────────────────────────
              SliverToBoxAdapter(
                child: CategoryList(
                  categories: homeProvider.categories,
                  selectedCategoryId: homeProvider.selectedCategoryId,
                  onCategorySelected: homeProvider.selectCategory,
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.paddingXXL),
              ),

              // ── Popüler yemekler (arama modunda gizle) ────────
              if (!homeProvider.isSearching)
                SliverToBoxAdapter(
                  child: PopularSection(
                    popularFoods: homeProvider.popularFoods,
                    onFoodTap: (foodId) {
                      Navigator.pushNamed(context, '/food-detail', arguments: foodId);
                    },
                  ),
                ),

              if (!homeProvider.isSearching)
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingXXL),
                ),

              // ── Tüm yemekler grid ────────────────────────────
              SliverToBoxAdapter(
                child: FoodGrid(
                  foods: homeProvider.filteredFoods,
                  onFoodTap: (foodId) {
                    Navigator.pushNamed(context, '/food-detail', arguments: foodId);
                  },
                ),
              ),

              // Alt boşluk
              const SliverToBoxAdapter(
                child: SizedBox(height: AppSizes.padding5XL),
              ),
            ],
          ),
        );
      },
    );
  }
}
