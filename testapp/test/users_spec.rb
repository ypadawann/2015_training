
require_relative '../model/_entity/database_information'
require_relative '../model/users'

describe Users do
  let(:id)       { 9876 }
  let(:name)          { 'anonymous' }
  let(:department_id) { 1 }
  let(:department)    { 'IT' }
  let(:password)      { 'password' }

  context do
    before do
      Department.create(id: department_id, name: department)
    end

    after do
      Timecard.destroy_all
      User.destroy_all
      Department.destroy_all
    end

    context 'when adding a new user' do
      it 'accepts valid inputs' do
        expect(Users.add(id, name, department_id, password)).to be true
      end

      it 'soundly accepts the user' do
        if Users.add(id, name, department_id, password)
          expect(User.exists?(id)).to be true
        end
      end

      it 'rejects a duplicated id' do
        Users.add(id, name, department_id, password)
        expect(Users.add(id, name, department_id, password)).to be false
      end

      it 'accepts a duplicated name' do
        Users.add(id, name, department_id, password)
        another_id = id + 1
        expect(Users.add(another_id, name, department_id, password)).to be true
      end

      it 'rejects an empty name' do
        expect(Users.add(id, '', department_id, password)).to be false
      end

      it 'rejects a long name' do
        long_name = 'a' * 51
        expect(Users.add(id, long_name, department_id, password)).to be false
      end

      it 'rejects if the department does not exist' do
        expect(Users.add(id, name, department_id + 1, password)).to be false
      end
    end

    context 'if there exists a user and' do
      before do
        Users.add(id, name, department_id, password)
      end

      context 'when deleting' do
        it 'succeeds with a valid user' do
          expect(Users.remove(id)).to be true
        end

        it 'fails if the user does not exist' do
          expect(Users.remove(id + 1)).to be false
        end

        it 'fails if a timecard belong to the user exists' do
          time = (Time.now).strftime('%X')
          day = Date.today
          Timecard.create(day: day, user_id: id, attendance: time)
          expect(Users.remove(id)).to be false
        end
      end

      context 'when getting the status' do
        it 'succeeds with a valid user' do
          expect(Users.status(id)).not_to be nil
        end

        it 'fails if the user does not exist' do
          expect(Users.status(id + 1)).to be nil
        end
      end
    end
  end
end
