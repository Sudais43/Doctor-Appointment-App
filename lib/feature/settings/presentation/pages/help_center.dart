import 'dart:math' as math; // Used for the trailing icon rotation

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skin_firts/feature/settings/presentation/widgets/custom_search_bar.dart'; // Corrected import path
import '../../../../core/theme/color_palette.dart';
import '../../../../core/widget/CustomButton.dart';
import '../../data/help_data.dart';
import '../../domain/entity/help_items.dart';

// Enum to manage which tab is currently selected
enum HelpCenterTab { faq, contactUs }

// --- 1. UNIFIED DATA MODEL ---
// This class will represent BOTH an FAQ and a Contact item


// --- 2. RENAMED WIDGET ---
class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  // --- STATE VARIABLES ---

  // Tracks which main tab is selected
  HelpCenterTab _selectedTab = HelpCenterTab.contactUs; // Defaulting to ContactUs

  // Tracks which FAQ category is selected
  String _selectedFaqCategory = 'General';

  // For the expandable list
  int? expandedIndex;

  // For the search bar
  final TextEditingController searchController = TextEditingController();
  String _currentQuery = "";

  // --- 3. COMBINED MASTER DATA LIST ---

  // --- METHODS ---

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _currentQuery = query;
      expandedIndex = null; // Reset list on new search
    });
    print("New Search Query : $_currentQuery");
  }

  @override
  Widget build(BuildContext context) {
    bool isFaqSelected = _selectedTab == HelpCenterTab.faq;

    // --- FILTERING LOGIC ---
    // This single logic block filters the list for all states
    List<HelpItem> currentList = allHelpItems.where((item) {
      bool categoryMatch = false;
      if (isFaqSelected) {
        // If FAQ tab, match against the selected FAQ category
        categoryMatch = item.category == _selectedFaqCategory;
      } else {
        // If ContactUs tab, match against the 'Contact' category
        categoryMatch = item.category == 'Contact';
      }

      if (!categoryMatch) return false;

      // Search logic (runs only if category matches)
      if (_currentQuery.isEmpty) return true;
      return item.question.toLowerCase().contains(_currentQuery.toLowerCase()) ||
          item.answer.toLowerCase().contains(_currentQuery.toLowerCase());
    }).toList();
    // --- END FILTERING ---

    return Scaffold(
      backgroundColor: LightColorPalette.white,
      body: SafeArea(
        child: Column(
          // --- 4. LAYOUT FIX ---
          // Removed 'mainAxisAlignment: MainAxisAlignment.end'
          children: [
            // --- HEADER (Unchanged) ---
            Container(
              height: 168,
              color: LightColorPalette.primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BackButton(color: LightColorPalette.white),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Help Center",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w600,
                              color: LightColorPalette.white,
                            ),
                          ),
                          Text(
                            "How can we help you?",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "LeagueSpartan",
                              fontWeight: FontWeight.w400,
                              color: LightColorPalette.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomSearchBar(
                      controller: searchController,
                      onSearchChanged: _handleSearch),
                ],
              ),
            ),
            SizedBox(height: 30),

            // --- 5. ENABLED TAB BUTTONS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    height: 41,
                    width: 155,
                    textStyle: TextStyle(
                      color: isFaqSelected
                          ? LightColorPalette.white
                          : LightColorPalette.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    BackgroundColor: isFaqSelected
                        ? LightColorPalette.primary
                        : LightColorPalette.secondary,
                    text: "FAQ",
                    onPressed: () {
                      setState(() {
                        _selectedTab = HelpCenterTab.faq;
                        expandedIndex = null; // Reset list
                      });
                    }),
                SizedBox(width: 30),
                CustomButton(
                    height: 41,
                    width: 155,
                    textStyle: TextStyle(
                      color: !isFaqSelected
                          ? LightColorPalette.white
                          : LightColorPalette.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    BackgroundColor: !isFaqSelected
                        ? LightColorPalette.primary
                        : LightColorPalette.secondary,
                    text: "Contact Us",
                    onPressed: () {
                      setState(() {
                        _selectedTab = HelpCenterTab.contactUs;
                        expandedIndex = null; // Reset list
                      });
                    }),
              ],
            ),
            SizedBox(height: 10),

            // --- 6. CONDITIONAL FAQ FILTERS ---
            // This row will appear/disappear smoothly
            AnimatedOpacity(
              opacity: isFaqSelected ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: isFaqSelected
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFaqFilterButton("Popular Topic"), // Added 'Popular' as per mockup
                  SizedBox(width: 10),
                  _buildFaqFilterButton("General"),
                  SizedBox(width: 10),
                  _buildFaqFilterButton("Services"),
                ],
              )
                  : SizedBox(height: 28), // Placeholder to prevent layout jump
            ),
            SizedBox(height: 20),

            // --- 7. EFFICIENT ANIMATED LIST ---
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                // We pass the already-filtered list to our single builder
                child: _buildHelpList(currentList),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper widget to build the FAQ category filter buttons
  Widget _buildFaqFilterButton(String categoryName) {
    bool isSelected = _selectedFaqCategory == categoryName;
    return CustomButton(
      height: 28,
      width: 102.37,
      textStyle: TextStyle(
        color: isSelected ? LightColorPalette.white : LightColorPalette.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      BackgroundColor:
      isSelected ? LightColorPalette.primary : LightColorPalette.secondary,
      text: categoryName,
      onPressed: () {
        setState(() {
          _selectedFaqCategory = categoryName;
          expandedIndex = null; // Reset list
        });
      },
    );
  }

  /// --- 8. SINGLE REUSABLE LIST BUILDER ---
  /// This one function builds both the FAQ and Contact Us lists
  /// It uses ExpansionTile, which matches your mockups and previous code
  Widget _buildHelpList(List<HelpItem> items) {
    // Show a message if the list is empty (e.g., no search results)
    if (items.isEmpty) {
      return Center(
        child: Text(
          "No items found.",
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      // The key is important for AnimatedSwitcher to detect a change
      key: ValueKey("${_selectedTab.name}-$_selectedFaqCategory"),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final bool isExpanded = expandedIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 8,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent, // Hides default divider
            ),
            child: Container(
              decoration: BoxDecoration(
                // Using tileColor from your previous code
                color: LightColorPalette.tileColor ?? LightColorPalette.secondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ExpansionTile(
                key: PageStorageKey(item.question), // Remembers expansion state

                // Conditionally add the icon
                leading: item.icon != null
                    ? SvgPicture.asset(
                  item.icon!,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      LightColorPalette.primary, BlendMode.srcIn),
                )
                    : null, // No icon for FAQs

                title: Text(
                  item.question,
                  style: TextStyle(
                    fontSize: 16, // Slightly larger for readability
                    fontFamily: "LeagueSpartan",
                    fontWeight: FontWeight.w500,
                    color: isExpanded
                        ? Colors.black
                        : LightColorPalette.primary,
                  ),
                ),

                // This trailing icon matches your 'ContactUs' file's implementation
                trailing: Transform.rotate(
                  angle: isExpanded ? (90 * math.pi / 180) : (-90 * math.pi / 180), // Rotates up when expanded
                  child: SvgPicture.asset(
                    "assets/icons/settings/down_arrow_icon.svg",
                    colorFilter: ColorFilter.mode(
                      LightColorPalette.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                onExpansionChanged: (expanded) {
                  setState(() {
                    expandedIndex = expanded ? index : null;
                  });
                },

                children: [
                  // This is the content inside the expanded tile
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 1,
                    color: LightColorPalette.secondary,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      item.answer,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "LeagueSpartan",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}