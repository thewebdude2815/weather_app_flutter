String getWeatherIcon(int condition) {
  if (condition < 300) {
    return 'assets/thundery.svg';
  } else if (condition < 400) {
    return 'assets/rainy.svg';
  } else if (condition < 600) {
    return 'assets/umbrella.svg';
  } else if (condition < 700) {
    return 'assets/snowy.svg';
  } else if (condition < 800) {
    return 'assets/surfy.svg';
  } else if (condition == 800) {
    return 'assets/sunny.svg';
  } else if (condition <= 804) {
    return 'assets/cloudy.svg';
  } else if (condition == 404) {
    return 'assets/error.svg';
  } else {
    return 'assets/error.svg';
  }
}

String getWeatherDailyIcon(int condition) {
  if (condition < 300) {
    return '🌩';
  } else if (condition < 400) {
    return '🌧';
  } else if (condition < 600) {
    return '☔️';
  } else if (condition < 700) {
    return '☃️';
  } else if (condition < 800) {
    return '🌫';
  } else if (condition == 800) {
    return '☀️';
  } else if (condition <= 804) {
    return '☁️';
  } else {
    return '🤷‍';
  }
}
