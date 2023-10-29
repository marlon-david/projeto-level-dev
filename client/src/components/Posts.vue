<script lang="ts">
import { defineComponent } from 'vue'
import api from '../http.ts'

interface Post {
  title: string,
  body: string
}

export default defineComponent({
  data() {
    return {
      posts: [] as Post[]
    }
  },

  methods: {
    async loadPosts() {
      const response = await api.get("/posts")
      this.posts = response.data as Post[]
    }
  },

  async mounted() {
    await this.loadPosts()
  }
})
</script>

<template>
  <h1>Posts</h1>

  <div v-for="post in posts">
    <div>
      <h3>{{ post.title }}</h3>
      <div>{{ post.body }}</div>
    </div>
  </div>
</template>