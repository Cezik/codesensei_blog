class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html do
        flash[:error] = t('application_controller,access_denied', default: 'Brak uprawnień!')
        redirect_to root_path
      end
      format.json { head :forbidden }
    end
  end
end
