module.exports = {
    apps: [
        {
            name: "my-backend-app",
            script: "index.js", // Entry point file of your app
            instances: "max", // Number of instances, "max" uses all available CPUs
            exec_mode: "cluster", // Use cluster mode for better performance
            env: {
                NODE_ENV: "development",
                PORT: 5000,
            },
            env_production: {
                NODE_ENV: "production",
                PORT: 5000,
            },
        },
    ],
};