class TaskPdfLoader < Prawn::Document
  def initialize(title, data)
    super()
    text title, align: :center, size: 24
    move_down 15
    text "Tasks: #{Date.today.beginning_of_week.strftime('%Y:%m:%d')} - #{Date.today.strftime('%Y:%m:%d')}", size: 16
    move_down 20
    table(tasks_table(data), column_widths: [200, 200, 140])
  end

  private

  def tasks_table(data)
    tasks = [["Title", "Description", "Watchers"]]

    data.each do |task|
      watchers = task.watchers.map { |user| user.full_name }
      tasks.push([task.title, task.description, watchers.join("\n")])
    end

    tasks
  end
end
