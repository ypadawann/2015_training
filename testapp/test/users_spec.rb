
require './model/_entity/database_information'
require './model/users'

describe Model::Users do
  let(:id)       { 9876 }
  let(:name)          { 'anonymous' }
  let(:department_id) { 1 }
  let(:department)    { 'IT' }
  let(:password)      { 'password' }

  context do
    before do
      Model::Department.create(id: department_id, name: department)
    end

    after do
      Model::Timecard.destroy_all
      Model::User.destroy_all
      Model::Department.destroy_all
    end

    context 'when adding a new user' do
      it 'accepts valid inputs' do
        expect(Model::Users.add(id, name, department, password)).to be true
      end

      it 'soundly accepts the user' do
        if Model::Users.add(id, name, department, password)
          expect(Model::User.exists?(id)).to be true
        end
      end

      it 'rejects a duplicated id' do
        Model::Users.add(id, name, department, password)
        expect(Model::Users.add(id, name, department, password)).to be false
      end

      it 'accepts a duplicated name' do
        Model::Users.add(id, name, department, password)
        another_id = id + 1
        expect(Model::Users.add(another_id, name, department, password)).to be true
      end

      it 'rejects an empty name' do
        expect(Model::Users.add(id, '', department, password)).to be false
      end

      it 'rejects a long name' do
        long_name = 'a' * 51
        expect(Model::Users.add(id, long_name, department, password)).to be false
      end

      it 'rejects if the department does not exist' do
        expect(Model::Users.add(id, name, department + '1', password)).to be false
      end
    end

    context 'if there exists a user and' do
      before do
        Model::Users.add(id, name, department, password)
      end

      context 'when deleting' do
        it 'succeeds with a valid user' do
          expect(Model::Users.remove(id)).to be true
        end

        it 'fails if the user does not exist' do
          expect(Model::Users.remove(id + 1)).to be false
        end

        it 'success even if a timecard belong to the user exists' do
          time = (Time.now).strftime('%X')
          day = Date.today
          Model::Timecard.create(day: day, user_id: id, attendance: time)
          expect(Model::Users.remove(id)).to be true
        end
      end

      context 'when getting the status' do
        it 'succeeds with a valid user' do
          expect(Model::Users.status(id)).not_to be nil
        end

        it 'fails if the user does not exist' do
          expect(Model::Users.status(id + 1)).to be nil
        end
      end
    end
  end
end
