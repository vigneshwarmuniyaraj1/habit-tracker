using HabitTracker.Api.Entities;
using Microsoft.EntityFrameworkCore;

namespace HabitTracker.Api.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users { get; set; } = null!;
    public DbSet<Habit> Habits { get; set; } = null!;
    public DbSet<HabitLog> HabitLogs { get; set; } = null!;
    public DbSet<Streak> Streaks { get; set; } = null!;
    public DbSet<Reminder> Reminders { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasIndex(u => u.Email).IsUnique();
            entity.HasIndex(u => u.Username).IsUnique();
        });

        modelBuilder.Entity<Habit>(entity =>
        {
            entity.HasOne(h => h.User)
                  .WithMany(u => u.Habits)
                  .HasForeignKey(h => h.UserId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<HabitLog>(entity =>
        {
            entity.HasOne(hl => hl.Habit)
                  .WithMany(h => h.HabitLogs)
                  .HasForeignKey(hl => hl.HabitId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Streak>(entity =>
        {
            entity.HasOne(s => s.Habit)
                  .WithOne(h => h.Streak)
                  .HasForeignKey<Streak>(s => s.HabitId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<Reminder>(entity =>
        {
            entity.HasOne(r => r.Habit)
                  .WithMany(h => h.Reminders)
                  .HasForeignKey(r => r.HabitId)
                  .OnDelete(DeleteBehavior.Cascade);
        });
    }
}
