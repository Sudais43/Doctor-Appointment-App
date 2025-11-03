class HelpItem {
  final String question; // Title for both FAQ and Contact
  final String answer;   // Content for both
  final String category; // 'General', 'Account', 'Services', 'Contact'
  final String? icon;    // Null for FAQs, path for Contact items

  HelpItem({
    required this.question,
    required this.answer,
    required this.category,
    this.icon,
  });
}