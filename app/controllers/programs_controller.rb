class ProgramsController < ApplicationController
  def index
    @stations = Station.all

    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.today
    #@selected_date = params[:date] ? Time.zone.parse(params[:date]).to_date : Time.zone.today.to_date
    @start_time = @selected_date.beginning_of_day + 5.hours #11/9 5:00
    @end_time = @start_time + 1.day #11/10 5:00
    @programs = Program.includes(:station).where(start_datetime: @start_time...@end_time).order(start_datetime: :asc)
  end

  def show
    
  end
end
