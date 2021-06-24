class TraderMailer < ApplicationMailer
    default from: 'ma7allyonline@gmail.com'

    def welcome_email
        @trader = params[:trader]
        @url  = 'http://www.google.com'
        mail(to: @trader.email, subject: 'Welcome to Ma7ally Online')
    end
end
