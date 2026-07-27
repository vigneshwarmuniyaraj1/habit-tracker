using HabitTracker.Api.Data;
using HabitTracker.Api.Entities;
using HabitTracker.Api.Models.Dtos;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Api.Services;

public class HabitService : IHabitService
{
    private readonly AppDbContext _db;

    public HabitService(AppDbContext db)
    {
        _db = db;
    }

    public async Task<List<HabitResponse>> GetAllHabitsAsync(int userId)
    {
        var habits = await _db.Habits
            .Include(h => h.Streak)
            .Where(h => h.UserId == userId && !h.IsArchived)
            .ToListAsync();

        return habits.Select(MapToResponse).ToList();
    }

    public async Task<HabitResponse?> GetHabitByIdAsync(int userId, int habitId)
    {
        var habit = await _db.Habits
            .Include(h => h.Streak)
            .FirstOrDefaultAsync(h => h.Id == habitId && h.UserId == userId);

        return habit == null ? null : MapToResponse(habit);
    }

    public async Task<HabitResponse> CreateHabitAsync(int userId, CreateHabitRequest request)
    {
        var habit = new Habit
        {
            UserId = userId,
            Name = request.Name,
            Category = request.Category,
            FrequencyType = request.FrequencyType,
            TargetDays = request.TargetDays
        };

        _db.Habits.Add(habit);

        var streak = new Streak
        {
            Habit = habit,
            CurrentStreak = 0,
            LongestStreak = 0
        };
        _db.Streaks.Add(streak);

        await _db.SaveChangesAsync();

        habit.Streak = streak;
        return MapToResponse(habit);
    }

    public async Task<HabitResponse?> UpdateHabitAsync(int userId, int habitId, UpdateHabitRequest request)
    {
        var habit = await _db.Habits
            .Include(h => h.Streak)
            .FirstOrDefaultAsync(h => h.Id == habitId && h.UserId == userId);

        if (habit == null)
            return null;

        habit.Name = request.Name;
        habit.Category = request.Category;
        habit.FrequencyType = request.FrequencyType;
        habit.TargetDays = request.TargetDays;
        habit.IsArchived = request.IsArchived;

        await _db.SaveChangesAsync();

        return MapToResponse(habit);
    }

    public async Task<bool> DeleteHabitAsync(int userId, int habitId)
    {
        var habit = await _db.Habits.FirstOrDefaultAsync(h => h.Id == habitId && h.UserId == userId);

        if (habit == null)
            return false;

        _db.Habits.Remove(habit);
        await _db.SaveChangesAsync();
        return true;
    }

    private static HabitResponse MapToResponse(Habit habit)
    {
        return new HabitResponse
        {
            Id = habit.Id,
            Name = habit.Name,
            Category = habit.Category,
            FrequencyType = habit.FrequencyType,
            TargetDays = habit.TargetDays,
            StartDate = habit.StartDate,
            IsArchived = habit.IsArchived,
            CurrentStreak = habit.Streak?.CurrentStreak ?? 0,
            LongestStreak = habit.Streak?.LongestStreak ?? 0
        };
    }
}
