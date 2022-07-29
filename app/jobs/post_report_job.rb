class PostReportJob < ApplicationJob
  queue_as :default

  def perform(user_id, post_id)
    user = User.find user_id
    post = Post.find post_id
    report = PostReport.generate(post)
    # Do something later
    # user -> report post -> email report
    PostReportMailer.post_report(user, post, report).deliver_now
    # cuando poner deliver_later rails pr defecto usara active job para enviarlo
    # pero como ya estamos dentro de un back job entondces podemos usar deliver now
  end
end
