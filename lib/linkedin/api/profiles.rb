module LinkedIn
  module API
    module Profiles
      def profile_api(selector)
        profile selector, Permissions::PROFILE_REQ
      end

      def profile(selector = '~', fields = nil, token = nil)
        fields ||= profile_fields
        query = "#{selector.to_param}:(#{Permissions.render_permissions fields})"
        get "v1/people/#{query}" do |req|
          req.headers.merge! 'x-li-auth-token' => token unless token.blank?
        end
      end

      def connections(selector = '~')
        profile [selector, 'connections'].join '/'
      end

      def search(options = {})
       get "v1/people-search?#{options.to_param}"
      end

      def connect_with(selector, subject, message, type = :friend, auth_name = nil, auth_value = nil)
        if auth_name.blank? || auth_value.blank?
          profile = profile_api selector
          token = profile.apiStandardProfileRequest_.headers_.values_.first.value
          auth_name, auth_value = *token.split(':')
        end

        connection_request = { recipients: { values: [ { person: { _path: "/people/#{selector.to_param}" } } ] },
                               subject: subject,
                               body: message,
                               'item-content' => {
                                 'invitation-request' => {
                                    'connect-type' => type,
                                    authorization: { name: auth_name, value: auth_value } } } }

        post 'v1/people/~/mailbox' do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['x-li-format'] = 'json'
          req.body = connection_request.to_json
        end
      end
    end
  end
end
