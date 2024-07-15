import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig(({ command, mode }) => {
  console.log('Vite Config Loaded');
  console.log(`Running in ${mode} mode`);
  console.log(`Command: ${command}`);

  return {
    plugins: [vue()],
    server: {
      host: true,
      port: 8081, // Your frontend port
      proxy: {
        '/api': {
          target: 'http://localhost:5156', // Backend URL
          changeOrigin: true,
          secure: false, // For non-HTTPS backend
          logLevel: 'debug', // Log proxy requests
        }
      }
    },
    build: {
      outDir: '../backend/App.Backend/wwwroot',
      emptyOutDir: true
    }
  }
});
