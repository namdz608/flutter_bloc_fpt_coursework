'use strict';

/**
 * field-trip service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::field-trip.field-trip');
