using System.Security.Claims;
using HabitTracker.Api.Models.Dtos;
using HabitTracker.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace HabitTracker.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class HabitController : ControllerBase
{
    private readonly IHabitService _habitService;

    public HabitController(IHabitService habitService)
    {
        _habitService = habitService;
    }

    private int GetUserId()
    {
        var userIdClaim = User.FindFirst(ClaimTypes.NameIdentifier)?.Value
                           ?? User.FindFirst("sub")?.Value;
        return int.Parse(userIdClaim!);
    }

    [HttpGet]
    public async Task<IActionResult> GetAllHabits()
    {
        var habits = await _habitService.GetAllHabitsAsync(GetUserId());
        return Ok(habits);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetHabitById(int id)
    {
        var habit = await _habitService.GetHabitByIdAsync(GetUserId(), id);
        if (habit == null)
            return NotFound(new { message = "Habit not found" });

        return Ok(habit);
    }

    [HttpPost]
    public async Task<IActionResult> CreateHabit(CreateHabitRequest request)
    {
        var habit = await _habitService.CreateHabitAsync(GetUserId(), request);
        return CreatedAtAction(nameof(GetHabitById), new { id = habit.Id }, habit);
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateHabit(int id, UpdateHabitRequest request)
    {
        var habit = await _habitService.UpdateHabitAsync(GetUserId(), id, request);
        if (habit == null)
            return NotFound(new { message = "Habit not found" });

        return Ok(habit);
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteHabit(int id)
    {
        var deleted = await _habitService.DeleteHabitAsync(GetUserId(), id);
        if (!deleted)
            return NotFound(new { message = "Habit not found" });

        return NoContent();
    }
}
