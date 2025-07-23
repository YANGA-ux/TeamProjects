// API测试脚本
const axios = require('axios');

const BASE_URL = 'http://localhost:8080/api';

async function testAPI() {
    console.log('开始测试API接口...\n');

    try {
        // 测试药品API
        console.log('1. 测试获取热门药品...');
        const drugsResponse = await axios.get(`${BASE_URL}/drugs/hot`);
        console.log('热门药品数量:', drugsResponse.data.data?.length || 0);
        console.log('状态:', drugsResponse.status);

        // 测试新闻API
        console.log('\n2. 测试获取最新新闻...');
        const newsResponse = await axios.get(`${BASE_URL}/news/latest?limit=3`);
        console.log('最新新闻数量:', newsResponse.data.data?.length || 0);
        console.log('状态:', newsResponse.status);

        // 测试搜索API
        console.log('\n3. 测试药品搜索...');
        const searchResponse = await axios.get(`${BASE_URL}/drugs/search?keyword=感冒`);
        console.log('搜索结果数量:', searchResponse.data.data?.length || 0);
        console.log('状态:', searchResponse.status);

        console.log('\n✅ 所有API测试通过！');

    } catch (error) {
        console.error('\n❌ API测试失败:', error.message);
        if (error.response) {
            console.error('状态码:', error.response.status);
            console.error('响应数据:', error.response.data);
        }
    }
}

// 如果直接运行此脚本
if (require.main === module) {
    testAPI();
}

module.exports = { testAPI }; 