class ProviderService {
  static const List<Map<String, dynamic>> mockProviders = [
    {
      'name': 'Juan Pérez',
      'serviceType': 'Electricista',
      'rating': 4.7,
      'imageUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
      'location': 'Ciudad de México',
      'description': 'Especialista en instalaciones eléctricas residenciales e industriales',
      'experience': '5 años de experiencia',
      'priceRange': '\$200 - \$500 por servicio'
    },
    {
      'name': 'María González',
      'serviceType': 'Plomera',
      'rating': 4.9,
      'imageUrl': 'https://randomuser.me/api/portraits/women/2.jpg',
      'location': 'Guadalajara',
      'description': 'Reparaciones y mantenimiento de sistemas de plomería',
      'experience': '8 años de experiencia',
      'priceRange': '\$150 - \$400 por servicio'
    },
    {
      'name': 'Carlos López',
      'serviceType': 'Carpintero',
      'rating': 4.5,
      'imageUrl': 'https://randomuser.me/api/portraits/men/3.jpg',
      'location': 'Monterrey',
      'description': 'Muebles personalizados y reparaciones de madera',
      'experience': '10 años de experiencia',
      'priceRange': '\$300 - \$600 por proyecto'
    }
  ];
}
