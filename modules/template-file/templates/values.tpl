client:
  extraEnv:
    API_ASSETS_ROUTE: /static-resource
    API_ASSETS_ACTION: assets
    API_MEDIA_ROUTE: /media
    API_MEDIA_SEARCH_ROUTE: "-search"
    API_META_ROUTE: /meta
    API_PROJECTS_ROUTE: /project
    API_RESOLVE_MEDIA_ROUTE: /resolve-media
    API_PROJECT_PUBLISH_ACTION: /publish-project
    API_SCENES_ROUTE: /collection
    API_SERVER_ADDRESS: api.${domain}
    API_SOCKET_ENDPOINT: /socket
    API_SERVER: https://api.${domain}
    APP_ENV: production
    CLIENT_ADDRESS: https://${domain}
    CLIENT_ENABLED: "true"
    CLIENT_SCENE_ROUTE: /scenes/
    CLIENT_LOCAL_SCENE_ROUTE: "/scene.html?scene_id="
    CORS_PROXY_SERVER: https://api.${domain}
    HOST_IP: https://api.${domain}
    HOST_PORT: "3000"
    GITHUB_ORG: xrengine
    GITHUB_REPO: spoke
    IS_MOZ: "false"
    NEXT_PUBLIC_API_SERVER: https://api.${domain}
    NODE_ENV: production
    NON_CORS_PROXY_DOMAINS: "reticulum.io,${domain},amazonaws.com"
    ROUTER_BASE_PATH: /spoke
    SITE_DESC: Connected Worlds for Everyone
    SITE_TITLE: TheOverlay
    THUMBNAIL_ROUTE: /thumbnail/
    THUMBNAIL_SERVER: https://api.${domain}
    USE_DIRECT_UPLOAD_API: "true"
    USE_HTTPS: "true"
  image:
    repository: ${repository_name}
    pullPolicy: IfNotPresent
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: eks.amazonaws.com/nodegroup
                operator: In
                values:
                  - ng-1
  ingress:
    annotations:
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    hosts:
      - host: ${domain}
        paths:
          - /
  replicaCount: 1
  service:
    type: NodePort
domain: ${domain}
mariadb:
  db:
    name: ${db_name}
    password: ${db_password}
    user: ${db_username}
  enabled: false
  externalHost: ${RDS_hostname}
rts:
  extraEnv:
    NAF_LISTEN_PORT: "8081"
api:
  config:
    aws:
      keys:
        access_key_id: ${S3_USER_ACCESS_KEY}
        secret_access_key: ${S3_USER_SECRET_KEY}
      s3:
        region: us-east-1
        static_resource_bucket: ${S3_STATIC_RESOURCES_BUCKET_NAME}
      cloudfront:
        domain: resources.${domain}
      sns:
        access_key_id: ${SNS_USER_ACCESS_KEY}
        application_id: ${AWS_SNS_APPLICATION_ID}
        region: us-east-1
        secret_access_key: ${SNS_SECRET_ACCESS_KEY}
        sender_id: ${AWS_SNS_SENDER_ID}
    host: https://${domain}/
  extraEnv:
    APP_ENV: production
    APP_HOST: https://${domain}
    APP_URL: https://${domain}
    AUTH_SECRET: ${INSERT_A_UUID_OR_SOMETHING_SIMILAR}
    AWS_SMS_ACCESS_KEY_ID: ${SNS_USER_ACCESS_KEY}
    AWS_SMS_REGION: us-east-1
    AWS_SMS_SECRET_ACCESS_KEY: ${SNS_SECRET_ACCESS_KEY}
    AWS_SMS_TOPIC_ARN: ${SNS_TOPIC_ARN}
    CLIENT_ENABLED: "false"
    CERT: certs/cert.pem
    KEY: certs/key.pem
    FACEBOOK_CALLBACK_URL: https://${domain}/auth/oauth/facebook
    FACEBOOK_CLIENT_ID: "${FB_OAUTH_CLIENT_ID}"
    FACEBOOK_CLIENT_SECRET: "${FB_OAUTH_SECRET}"
    FORCE_DB_REFRESH: "false"
    GAMESERVER_DOMAIN: gameserver.${domain}
    GITHUB_CALLBACK_URL: https://${domain}/auth/oauth/github
    GITHUB_CLIENT_ID: "${GITHUB_OAUTH_CLIENT_ID}"
    GITHUB_CLIENT_SECRET: "${GITHUB_OAUTH_SECRET}"
    GOOGLE_CALLBACK_URL: https://${domain}/auth/oauth/google
    GOOGLE_CLIENT_ID: "${GOOGLE_OAUTH_CLIENT_ID}"
    GOOGLE_CLIENT_SECRET: "${GOOGLE_OAUTH_SECRET}"
    LINKEDIN_CALLBACK_URL: https://${domain}/auth/oauth/linkedin
    LINKEDIN_CLIENT_ID: "${LINKEDIN_OAUTH_CLIENT_ID}"
    LINKEDIN_CIENT_SECRET: "${LINKEDIN_OAUTH_CLIENT_SECRET}"
    MAGICLINK_EMAIL_SUBJECT: Login to TheOverlay
    MAIL_FROM: info@login.${domain}
    SERVER_HOST: "api.${domain}"
    SERVER_MODE: "api"
    SERVER_PORT: "3030"
    SMTP_FROM_EMAIL: info@login.${domain}
    SMTP_FROM_NAME: noreply
    SMTP_HOST: email-smtp.${SES_REGION}.amazonaws.com
    SMTP_PASS: ${AWS_SMTP_PASSWORD}
    SMTP_PORT: "465"
    SMTP_SECURE: "true"
    SMTP_USER: ${AWS_SMTP_USER_ID}
    STORAGE_PROVIDER: aws
    STORAGE_AWS_ACCESS_KEY_ID: ${S3_USER_ACCESS_KEY}
    STORAGE_AWS_ACCESS_KEY_SECRET: ${S3_USER_SECRET_KEY}
    STORAGE_CLOUDFRONT_DOMAIN: resources.${domain}
    STORAGE_CLOUDFRONT_DISTRIBUTION_ID: ${cloudfront_distribution_id}
    STORAGE_S3_REGION: us-east-1
    STORAGE_S3_STATIC_RESOURCE_BUCKET: ${S3_STATIC_RESOURCES_BUCKET_NAME}
    STORAGE_S3_AVATAR_DIRECTORY: avatars
    TWITTER_CALLBACK_URL: https://${domain}/auth/oauth/linkedin
    TWITTER_CLIENT_ID: "${TWITTER_OAUTH_CLIENT_ID}"
    TWITTER_CIENT_SECRET: "${TWITTER_OAUTH_CLIENT_ID}"
    DEFAULT_AVATAR_ID: Allison
    AVATAR_FILE_ALLOWED_EXTENSIONS: ".glb,.gltf,.vrm,.fbx"
    MIN_AVATAR_FILE_SIZE: "0"
    MAX_AVATAR_FILE_SIZE: "15728640"
    MIN_THUMBNAIL_FILE_SIZE: "0"
    MAX_THUMBNAIL_FILE_SIZE: "2097152"
    STORAGE_S3_DEV_MODE: dev
    PRESIGNED_URL_EXPIRATION_DURATION: "3600"
  image:
    repository: ${repository_name}
  service:
    type: NodePort
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: eks.amazonaws.com/nodegroup
                operator: In
                values:
                  - ng-1
  ingress:
    annotations:
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/enable-cors: "false"
      nginx.ingress.kubernetes.io/proxy-body-size: 256m
      nginx.ingress.kubernetes.io/affinity: cookie
      nginx.ingress.kubernetes.io/affinity-mode: persistent
      nginx.ingress.kubernetes.io/server-snippet: |
        location ~* /cors-proxy/(.*) {
          proxy_http_version 1.1;
          proxy_pass_request_headers on;
          proxy_hide_header Access-Control-Allow-Origin;
          add_header Access-Control-Allow-Origin $http_origin;
          proxy_intercept_errors on;
          error_page 301 302 307 = @handle_redirects;
          proxy_pass https://$1?$args;
        }

        location @handle_redirects {
          set $saved_redirect_location '$upstream_http_location';
          proxy_pass_request_headers on;
          proxy_hide_header Access-Control-Allow-Origin;
          add_header Access-Control-Allow-Origin "$http_origin";
          proxy_pass $saved_redirect_location;
        }
    hosts:
      - host: api.${domain}
        paths:
          - /
  replicaCount: 2

release:
  name: prod

media:
  enabled: false
  config:
    aws:
      keys:
        access_key_id: ${IAM_USER_ACCESS_KEY}
        secret_access_key: <IAM_USER_SECRET_KEY}
      s3:
        region: us-east-1
        static_resource_bucket: <static-resources-bucket-name>
      cloudfront:
        domain: resources.<domain>
      sns:
        access_key_id: <SNS_USER_ACCESS_KEY>
        application_id: <AWS_SNS_APPLICATION_ID>
        region: us-east-1
        secret_access_key: <SNS_USER_ACCESS_KEY>
        sender_id: <AWS_SNS_SENDER_ID>
    host: https://<domain>/
  extraEnv:
    APP_ENV: production
    APP_HOST: <domain>
    APP_URL: https://<domain>
    AUTH_SECRET: <INSERT_A_UUID_OR_SOMETHING_SIMILAR>
    AWS_SMS_ACCESS_KEY_ID: <SNS_USER_ACCESS_KEY>
    AWS_SMS_REGION: us-east-1
    AWS_SMS_SECRET_ACCESS_KEY: <SNS_USER_ACCESS_KEY>
    AWS_SMS_TOPIC_ARN: <SNS_TOPIC_ARN>
    FACEBOOK_CALLBACK_URL: https://<domain>/auth/oauth/facebook
    FACEBOOK_CLIENT_ID: "<FB_OAUTH_CLIENT_ID>"
    FACEBOOK_CLIENT_SECRET: "<FB_OAUTH_SECRET>"
    FORCE_DB_REFRESH: "false"
    GITHUB_CALLBACK_URL: https://<domain>/auth/oauth/github
    GITHUB_CLIENT_ID: "<GITHUB_OAUTH_CLIENT_ID>"
    GITHUB_CLIENT_SECRET: "<GITHUB_OAUTH_SECRET>"
    GOOGLE_CALLBACK_URL: https://<domain>/auth/oauth/google
    GOOGLE_CLIENT_ID: "<GOOGLE_OAUTH_CLIENT_ID>"
    GOOGLE_CLIENT_SECRET: "<GOOGLE_OAUTH_SECRET>"
    MAGICLINK_EMAIL_SUBJECT: Login to TheOverlay
    MAIL_FROM: info@login.<domain>
    SERVER_HOST: "api.<domain>"
    SMTP_FROM_EMAIL: info@login.<domain>
    SMTP_FROM_NAME: noreply
    SMTP_HOST: email-smtp.<SES_REGION>.amazonaws.com
    SMTP_PASS: <AWS_SMTP_PASSWORD>
    SMTP_PORT: "465"
    SMTP_SECURE: "true"
    SMTP_USER: <AWS_SMTP_USER_ID>
    STORAGE_PROVIDER: aws
    STORAGE_AWS_ACCESS_KEY_ID: <S3_USER_ACCESS_KEY>
    STORAGE_AWS_ACCESS_KEY_SECRET: <S3_USER_SECRET>
    STORAGE_CLOUDFRONT_DOMAIN: resources.<domain>
    STORAGE_CLOUDFRONT_DISTRIBUTION_ID: <cloudfront_distribution_id>
    STORAGE_S3_REGION: us-east-1
    STORAGE_S3_STATIC_RESOURCE_BUCKET: <S3_STATIC_RESOURCES_BUCKET_NAME>
  image:
    repository: <repository_name>
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: eks.amazonaws.com/nodegroup
                operator: In
                values:
                  - ng-1
  ingress:
    annotations:
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/enable-cors: "true"
      nginx.ingress.kubernetes.io/cors-allow-origin: https://<domain>
      nginx.ingress.kubernetes.io/proxy-body-size: 256m
    hosts:
      - host: api.${domain}
        paths:
          - /video
  service:
    type: NodePort

gameserver:
  image:
    repository: ${gameserver_repository_name}
    pullPolicy: IfNotPresent
  extraEnv:
    APP_ENV: production
    APP_HOST: ${domain}
    AUTH_SECRET: ${SAME_AUTH_SECRET_AS_IN_API}
    APP_URL: https://${domain}
    ROUTE53_ACCESS_KEY_ID: ${ROUTE53_USER_ACCESS_KEY}
    ROUTE53_ACCESS_KEY_SECRET: ${ROUTE53_USER_SECRET}
    ROUTE53_HOSTED_ZONE_ID: ${ROUTE53_HOSTED_ZONE_ID}
    RTC_START_PORT: "40000"
    RTC_END_PORT: "40099"
    RTC_PORT_BLOCK_SIZE: "100"
    GAMESERVER_DOMAIN: gameserver.${domain}
    GAMESERVER_MODE: "realtime"
    GAMESERVER_PORT: "3031"
    STORAGE_PROVIDER: aws
    STORAGE_AWS_ACCESS_KEY_ID: ${S3_USER_ACCESS_KEY}
    STORAGE_AWS_ACCESS_KEY_SECRET: ${S3_USER_SECRET_KEY}
    STORAGE_CLOUDFRONT_DOMAIN: resources.${domain}
    STORAGE_CLOUDFRONT_DISTRIBUTION_ID: ${cloudfront_distribution_id}
    STORAGE_S3_REGION: us-east-1
    STORAGE_S3_STATIC_RESOURCE_BUCKET: ${S3_STATIC_RESOURCES_BUCKET_NAME}
    CERT: certs/cert.pem
    KEY: certs/key.pem
  ingress:
    annotations:
      kubernetes.io/ingress.class: nginx
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/enable-cors: "false"
      nginx.ingress.kubernetes.io/proxy-body-size: 256m
      nginx.ingress.kubernetes.io/affinity: cookie
      nginx.ingress.kubernetes.io/affinity-mode: persistent
      nginx.ingress.kubernetes.io/server-snippet: |
        location ~* /socket.io/([a-zA-Z0-9\.]*)/([a-zA-Z0-9\.]*)/?$ {
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "Upgrade";
          proxy_pass http://$1:$2/socket.io/?$args;
        }
    host: gameserver.${domain}
  resources:
    limits:
      cpu: "2"
    requests:
      cpu: "1.5"
  buffer:
    bufferSize: 4
    minReplicas: 4
    maxReplicas: 24
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: eks.amazonaws.com/nodegroup
                operator: In
                values:
                  - ng-gameservers-1

builder:
  extraEnv:
    RELEASE_NAME: ${RELEASE_NAME}
    AWS_ACCESS_KEY: ${AWS_ACCESS_KEY}
    AWS_SECRET: ${AWS_SECRET}
    AWS_REGION: ${AWS_REGION}
    CLUSTER_NAME: ${CLUSTER_NAME}
    ECR_URL: ${ECR_URL}
    REPO_NAME: ${builder_REPO_NAME}
    DOCKER_LABEL: ${DOCKER_LABEL}
    PRIVATE_ECR: "false"
    STORAGE_PROVIDER: aws
    STORAGE_AWS_ACCESS_KEY_ID: ${S3_USER_ACCESS_KEY}
    STORAGE_AWS_ACCESS_KEY_SECRET: ${S3_USER_SECRET_KEY}
    STORAGE_CLOUDFRONT_DOMAIN: ${CLOUDFRONT_DOMAIN}
    STORAGE_CLOUDFRONT_DISTRIBUTION_ID: ${cloudfront_distribution_id}
    STORAGE_S3_REGION: ${S3_REGION}
    STORAGE_S3_STATIC_RESOURCE_BUCKET: ${S3_STATIC_RESOURCES_BUCKET_NAME}
    STORAGE_S3_AVATAR_DIRECTORY: avatars
    VITE_APP_HOST: app.${domain}
    VITE_APP_PORT: "3000"
    VITE_SERVER_HOST: api.${domain}
    VITE_SERVER_PORT: "3030"
    VITE_GAMESERVER_HOST: gameserver.${domain}
    VITE_GAMESERVER_PORT: "3031"
    VITE_ROOT_REDIRECT: "false"
    VITE_READY_PLAYER_ME_URL: https://xre.readyplayer.me
    VITE_LOCAL_STORAGE_KEY: theoverlay-client-store-key-v1
    VITE_FEATHERS_STORE_KEY: TheOverlay-Auth-Store
    VITE_GA_MEASUREMENT_ID: ${GOOGLE_ANALYTICS_MEASUREMENT_ID}
    VITE_MAPBOX_API_KEY: ${MAPBOX_API_KEY}
    VITE_ETH_MARKETPLACE: ${ETH_MARKETPLACE_ADDRESS}
  image:
    repository: ${ECR_URL}/xrengine-dev-builder
  service:
    type: NodePort
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: eks.amazonaws.com/nodegroup
                operator: In
                values:
                  - ng-${RELEASE_NAME}-builder-1
  replicaCount: 1
  
testbot:
  extraEnv:
    APP_HOST: ${domain}
  image:
    repository: ${testbot_repository_name}
    pullPolicy: IfNotPresent
