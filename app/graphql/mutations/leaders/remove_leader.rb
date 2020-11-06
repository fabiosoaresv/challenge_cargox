module Mutations
  module Leaders
    class RemoveLeader < Mutations::BaseMutation
      field :leader, Types::LeaderType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        leader = Leader.find(id)
        leader.destroy!

        { leader: leader }
      end
    end
  end
end
