class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson

def show
end

private

def require_authorized_for_current_lesson
	if current_user.enrolled_in?(current_lesson.section.course) == false && current_lesson.section.course.user != current_user
		flash[:alert] = "You are not enrolled in this course. Please enroll first to view any corresponding lessons. Thank you."
		redirect_to course_path(current_lesson.section.course)
	end
end

helper_method :current_lesson
def current_lesson
	@current_lesson ||= Lesson.find(params[:id])
end

end
