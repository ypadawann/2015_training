
require_relative '../model/_entity/database_information'
require_relative '../model/departments'
require_relative '../model/users'

describe Departments do
  let(:id)       { 9876 }
  let(:name)          { 'anonymous' }
  let(:department_id) { 1 }
  let(:department)    { 'IT' }
  let(:password)      { 'password' }

  context do
    after do
      User.destroy_all
      Department.destroy_all
    end

    context 'when adding a new department' do
      it 'accepts valid inputs' do
        expect(Departments.add(department)).to be true
      end

      it 'rejects a duplicated name' do
        Departments.add(department)
        expect(Departments.add(department)).to be false
      end

      it 'rejects an empty name' do
        expect(Departments.add('')).to be false
      end
    end

    context 'when there exists a department' do
      before do
        Department.create(id: department_id, name: department)
      end

      context 'when deleting a department' do
        it 'succeeds with a valid department' do
          expect(Departments.remove(department_id)).to be true
        end

        it 'fails if the department does not exist' do
          expect(Departments.remove(department_id + 1)).to be false
        end

        after do
          Department.destroy_all
        end
      end

      context 'when there exists a user' do
        before do
          Users.add(id, name, department_id, password)
        end

        it 'returns users belongs to it' do
          expect(Departments.users(department_id)).not_to be nil
        end
      end
    end
  end
end
