import { mount } from '@vue/test-utils';
import { describe, it, expect } from 'vitest';
import ShoppingCart from '../ShoppingCart.vue';

describe('ShoppingCart.vue', () => {
  it('deve renderizar corretamente', () => {
    const wrapper = mount(ShoppingCart, {
      props: { cartItems: [] }
    });

    expect(wrapper.exists()).toBe(true);
  });
});