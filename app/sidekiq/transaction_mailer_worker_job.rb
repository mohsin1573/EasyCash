class TransactionMailerWorkerJob
  include Sidekiq::Job

  def perform(user_id, transaction_id)
    user = User.find(user_id)
    transaction = Transaction.find(transaction_id)
    TransactionMailer.transaction_notification(user, transaction).deliver_now
  end
end
