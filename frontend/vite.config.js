import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    proxy: {
      '/api': {
        target: 'http://localhost:8080', // 你的后端端口
        changeOrigin: true,
        rewrite: path => path.replace(/^\/api/, '/api')
      }
    }
  }
})