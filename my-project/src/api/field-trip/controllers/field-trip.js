const { createCoreController } = require("@strapi/strapi").factories;

module.exports = createCoreController(
  "api::field-trip.field-trip",
  ({ strapi }) => ({
    // Method 1: Creating an entirely custom action
    async exampleAction(ctx) {
      try {
        ctx.body = "ok";
      } catch (err) {
        ctx.body = err;
      }
    },

    // Method 2: Wrapping a core action (leaves core logic in place)
    async find(ctx) {
      // some logic here
      const { data, meta } = await super.find(ctx);
      let info = [];
      await data.map((item) => {
        let obj = {};
        obj.id = item.id;
        obj.name = item.attributes.name;
        obj.description = item.attributes.description;
        obj.risk_assessment = item.attributes.risk_assessment;
        obj.destination = item.attributes.destination;
        obj.date_trip = item.attributes.date_trip;
        obj.phone_number = item.attributes.phone_number;
        obj.organizational_units = item.attributes.organizational_units;
        info.push(obj);
      });
      paginate = {};
      paginate.currentPage = meta.pagination.pageCount;
      paginate.totalPage = meta.pagination.total;

      console.log("data", meta);
      return { info, paginate };
    },

    // Method 3: Replacing a core action
    async findOne(ctx) {
      const { id } = ctx.params;
      const { query } = ctx;

      const entity = await strapi
        .service("api::field-trip.field-trip")
        .findOne(id, query);
      const sanitizedEntity = await this.sanitizeOutput(entity, ctx);

      return this.transformResponse(sanitizedEntity);
    },
  })
);
