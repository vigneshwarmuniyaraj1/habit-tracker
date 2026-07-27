namespace HabitTracker.Api.Entities;

public class Reminder
{
    public int Id { get; set; }
    public int HabitId { get; set; }
    public Habit Habit { get; set; } = null!;

    public TimeSpan ReminderTime { get; set; }
    public bool IsEnabled { get; set; } = true;
}
