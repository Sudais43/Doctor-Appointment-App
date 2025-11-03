import '../domain/entity/help_items.dart';

final List<HelpItem> allHelpItems = [
  // --- FAQ Items (from our previous discussion) ---
  HelpItem(
    question: 'What is your return policy?',
    answer:
    'Our return policy lasts 30 days. If 30 days have gone by since your purchase, unfortunately we can’t offer you a refund or exchange.',
    category: 'Popular Topic',
  ),
  HelpItem(
    question: 'How do I track my order?',
    answer:
    'Once your order has shipped, we will send you an email with the tracking number and a link to track it online.',
    category: 'General',
  ),
  HelpItem(
    question: 'Can I change or cancel my order?',
    answer:
    'Yes, you can change or cancel your order within 24 hours of placing it by contacting our customer support.',
    category: 'Services',
  ),
  HelpItem(
    question: 'How do I reset my password?',
    answer:
    'Go to the login page and click "Forgot Password". You will receive an email with instructions.',
    category: 'Account',
  ),

  // --- Contact Us Items (from your new 'addresses' list) ---
  HelpItem(
    question: 'Customer Service',
    answer: 'Contact our team at +1 234 567 890 or support@example.com.', // Added example content
    category: 'Contact',
    icon: 'assets/icons/settings/customer_service_icon.svg',
  ),
  HelpItem(
    question: 'Website',
    answer: 'Visit our official website at www.example.com.', // Added example content
    category: 'Contact',
    icon: 'assets/icons/settings/website_icon.svg',
  ),
  HelpItem(
    question: 'WhatsApp',
    answer: 'Chat with us on Whatsapp at +1 234 567 891.', // Added example content
    category: 'Contact',
    icon: 'assets/icons/settings/whatsapp_icon.svg',
  ),
  HelpItem(
    question: 'Facebook',
    answer: 'Find us on Facebook: @ExampleApp', // Added example content
    category: 'Contact',
    icon: 'assets/icons/settings/facebook_icon.svg',
  ),
  HelpItem(
    question: 'Instagram',
    answer: 'Follow us on Instagram: @ExampleApp', // Added example content
    category: 'Contact',
    icon: 'assets/icons/settings/instagram_icon.svg',
  ),
];