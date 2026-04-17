%w[demo1@example.com demo2@example.com demo3@example.com].each do |email|
  User.find_or_create_by!(email_address: email) do |user|
    user.password = "clever123"
  end
end
