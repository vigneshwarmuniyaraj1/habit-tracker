namespace HabitTracker.Api.Entities;

public class Streak
{
    public int Id { get; set; }
    public int HabitId { get; set; }
    public Habit Habit { get; set; } = null!;

    public int CurrentStreak { get; set; } = 0;
    public int LongestStreak { get; set; } = 0;
    public DateTime? LastCompletedDate { get; set; }
}
