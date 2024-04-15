class UserMailer < ApplicationMailer
  default from: 'dikruppengelmann@gmail.com'

  def user_register(user)
    @user = user
    mail(to: user['email'], subject: 'Usuário cadastrado!')
  end
end
