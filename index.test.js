const request = require('supertest');
const app = require('.');

describe('post @user',()=>{
    describe('given a username and password', () => {
        test('should respond with a 200 status code', async () => {
          const response = await request(app).get('/book/authors').send({
          });
          console.log(response);
          expect(response.statusCode).toBe(200);
        });

    describe('get user orders',()=>{
      test('should return status code 200',async ()=>{
        const response = await request(app).post('/Get/user/orders').send({
          UserName : 'm.khizar133'
        })
        expect(response.statusCode).toBe(200);
      })
    })


    describe('get user checkout details',()=>{
      test('should return user checkout details',async ()=>{
        const response = await request(app).post('/get/user/checkout').send({
          UserName : 'm.khizar133'
        })
        expect(response.statusCode).toBe(200);
      })
    })

    describe('get user messages with customer support',()=>{
      test('should return user messages with customer support',async ()=>{
        const response = await request(app).post('/get/message/history').send({
          user : 'm.khizar133'
        })
        expect(response.statusCode).toBe(200);
      })
    })

    describe('submit user reviews for book',()=>{
      test('should return 200 for successfull review submission',async ()=>{
        const response = await request(app).post('/user/review').send({
          ratingValue: 3,
          reviewContent: 'very good book',
          user:'m.khizar133',
          isbn: '9781853262449'
        })
        expect(response.statusCode).toBe(200);
      })
    })
})
})
