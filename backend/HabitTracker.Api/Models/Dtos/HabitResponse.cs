using HabitTracker.Api.Models.Enums;

namespace HabitTracker.Api.Models.Dtos;

public class HabitResponse
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public FrequencyType FrequencyType { get; set; }
    public List<int> TargetDays { get; set; } = new();
    public DateTime StartDate { get; set; }
    public bool IsArchived { get; set; }
    public int CurrentStreak { get; set; }
    public int LongestStreak { get; set; }
}
