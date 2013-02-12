def distance_traveled(time)
  primary_distance(time) + secondary_distance(time)
end

def primary_distance
  primary_time = [time, @delay].min
  0.5 * primary_acc * primary_time * primary_time
end

def primary_acc
  @primary_force / @mass
end

def primary_vel
  primary_acc * @delay
end

def secondary_acc
  (@primary_force + @secondary_force) / @mass
end

def secondary_distance(time)
  secondary_time = time - @delay
  if(secondary_time > 0)
    primary_vel * secondary_time + 5 * secondary_acc * secondary_time * secondary_time
  else
    0
  end
end
