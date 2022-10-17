echo "Building..."

flutter build web --release --dart-define=API_URL=35.173.78.81:5000 --dart-define=JWT_SIGN_KEY=xxxxxx --dart-define=HTTPS=false