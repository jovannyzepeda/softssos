module PermissionsConcern
	#es para agergar tiposdeusuarios yu permisos
	extend ActiveSupport::Concern
	def is_normal_user?
		self.privilegio >= 1
	end
	def is_admin?
		self.privilegio >= 2
	end
end