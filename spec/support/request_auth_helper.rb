module RequestAuthHelper
  def sign_in(user, password: "password")
    post session_path, params: {
      session: {
        username: user.username,
        password: password
      }
    }
  end
end
