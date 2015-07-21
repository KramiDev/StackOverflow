module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Войти'
  end

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Зарегистрироваться'
  end

  def sign_out_user
    visit root_path
    click_on 'Выйти'
  end

  def create_question_upload_file
    visit new_question_path

    within '#new_question' do
      fill_in 'Сформулируйте суть своего вопроса', with: 'Заголовок для вопроса'
      fill_in 'Опишите подробно свой вопрос', with: 'Тело для вопроса'
      attach_file 'Файл', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Задать вопрос'
    end
  end

  def create_answer_upload_file(question)
    visit question_path(question)

    fill_in 'Напишите свой ответ', with: 'МойРедкийОтвет'
    attach_file 'Файл', "#{Rails.root}/spec/rails_helper.rb"
    click_on 'Ответить'
  end

  def sign_in_facebook
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        info: {email: 'test@example.com'},
        provider: 'facebook',
        uid: '123456'
    )
  end

  def sign_in_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '123456'
    )
  end
end