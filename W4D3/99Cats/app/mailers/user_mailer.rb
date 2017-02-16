class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_email(user)
    @user = user
    @url = 'session/new'
    mail(to: 'tuc64377@temple.edu', subject: "Bienvenidos, amigo")
  end
end
