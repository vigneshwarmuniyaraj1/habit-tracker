using HabitTracker.Api.Models.Enums;

namespace HabitTracker.Api.Entities;

public class Habit
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public User User { get; set; } = null!;

    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public FrequencyType FrequencyType { get; set; } = FrequencyType.Daily;
    public List<int> TargetDays { get; set; } = new();
    public DateTime StartDate { get; set; } = DateTime.UtcNow;
    public bool IsArchived { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public ICollection<HabitLog> HabitLogs { get; set; } = new List<HabitLog>();
    public Streak? Streak { get; set; }
    public ICollection<Reminder> Reminders { get; set; } = new List<Reminder>();
}
