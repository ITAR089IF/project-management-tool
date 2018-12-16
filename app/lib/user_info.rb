class UserInfo
  def initialize(user)
    @user = user
  end

  def report
    array_of_dates = (6.days.ago.to_date..Date.today).map{ |date| date }
    user_info = []
    array_of_dates.each do |date|
      created_tasks = @user.created_tasks.created_at_date(date).count
      assigned_tasks = @user.assigned_tasks.assigned_at_date(date).count
      completed_tasks = @user.completed_tasks.completed_at_date(date).count
      user_info.push(created: created_tasks, assigned: assigned_tasks, completed: completed_tasks, date: date.strftime("%d/%m/%y"))
    end
    user_info
  end
end