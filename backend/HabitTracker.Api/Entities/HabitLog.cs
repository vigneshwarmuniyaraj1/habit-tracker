namespace HabitTracker.Api.Entities;

public class HabitLog
{
    public int Id { get; set; }
    public int HabitId { get; set; }
    public Habit Habit { get; set; } = null!;

    public DateTime CompletedAt { get; set; } = DateTime.UtcNow;
    public string? Notes { get; set; }
}
