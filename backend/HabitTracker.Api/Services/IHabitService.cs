using HabitTracker.Api.Models.Dtos;

namespace HabitTracker.Api.Services;

public interface IHabitService
{
    Task<List<HabitResponse>> GetAllHabitsAsync(int userId);
    Task<HabitResponse?> GetHabitByIdAsync(int userId, int habitId);
    Task<HabitResponse> CreateHabitAsync(int userId, CreateHabitRequest request);
    Task<HabitResponse?> UpdateHabitAsync(int userId, int habitId, UpdateHabitRequest request);
    Task<bool> DeleteHabitAsync(int userId, int habitId);
}
