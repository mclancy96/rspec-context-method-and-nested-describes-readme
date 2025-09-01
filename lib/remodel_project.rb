# frozen_string_literal: true

# Represents a home remodel project with phases and status
class RemodelProject
  attr_reader :name, :phases, :status

  def initialize(name)
    @name = name
    @phases = ["planning", "demolition", "construction", "finishing"]
    @status = "not started"
    @current_phase = nil
  end

  def start
    @status = "in progress"
    @current_phase = @phases.first
  end

  def advance_phase
    return unless @status == "in progress"
    idx = @phases.index(@current_phase)
    if idx && idx < @phases.size - 1
      @current_phase = @phases[idx + 1]
    else
      @status = "completed"
      @current_phase = nil
    end
  end

  def current_phase
    @current_phase
  end

  def completed?
    @status == "completed"
  end
end

# Manages multiple remodel projects
class ProjectManager
  attr_reader :projects

  def initialize
    @projects = []
  end

  def add_project(project)
    @projects << project
  end

  def find_by_status(status)
    @projects.select { |p| p.status == status }
  end
end
