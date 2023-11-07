class ProgramsController < ApplicationController
  def index
    @stations = Station.all

    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.today
    @start_time = @selected_date.beginning_of_day + 5.hours
    @end_time = @start_time + 1.day
    @programs = Program.includes(:station).where(start_datetime: @start_time..@end_time)
  end
end
