using HabitTracker.Api.Models.Enums;

namespace HabitTracker.Api.Models.Dtos;

public class CreateHabitRequest
{
    public string Name { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public FrequencyType FrequencyType { get; set; }
    public List<int> TargetDays { get; set; } = new();
}
