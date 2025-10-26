class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  protected

  def authenticate_user!(opts = {})  # ← メソッド定義が必要
    return super if user_signed_in?

    respond_to do |format|  # ← メソッドの中に入れる
      format.html { redirect_to new_user_session_path, alert: "ログインしてください。" and return }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "flash",
          partial: "shared/flash_message",
          locals: { alert: "ログインしてください。" }
        )
        return
      end
    end
  end  # ← メソッドの終了
end
