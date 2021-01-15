class Item {
  Item(
      {this.serialnumber,
      this.name,
      this.price,
      this.cost,
      this.image,
      this.adurl = 'https://youtu.be/NOTlRkO3Syk',
      this.rating = const {},
      this.specs = const {}});
  int serialnumber;
  String name;
  double price;
  double cost;
  String image;
  String adurl;
  Map<double, double> rating;
  Map<String, Map<String, String>> specs = {
    'Taste': {
      'Sweet': 'Yes',
      'Bitter': 'Yes',
      'Salty': 'No',
    },
    'Package': {
      'Material': 'Plastic',
      'Sealing': 'Regular',
      'Resealable': 'No',
    },
    'Ingredients': {'Almonds': 'NO', 'Nuts': 'Yes'}
  };
  double getrating() {
    double rat = 0, no = 0;
    for (double i in rating.keys) {
      rat += (i * rating[i]);
      no += rating[i];
    }
    if (no == 0) return 0;
    return rat / no;
  }

  double gettotal() {
    double no = 0;
    for (double i in rating.keys) {
      no += rating[i];
    }

    if (no == 0) return 0;
    return no;
  }
}
