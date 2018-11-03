class VirtualModel::UserRole

    roles = {role: [
        { id:1, title:"Admin" },
        { id:2, title:"Redaktor" },
        { id:3, title:"Insider" },
        { id:9, title:"Plebs" }
    ]}
    @@roles = (RecursiveOpenStruct.new(roles, recurse_over_arrays: true)).role

    def self.all
        @@roles
    end

    def self.find(r)
        @@roles.each do |role|
            return role if role.id == r.to_i
        end
    end

end

