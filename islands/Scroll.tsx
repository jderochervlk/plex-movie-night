import { useEffect } from "preact/hooks";

export const Scroll = () => {
  useEffect(() => {
    const scrollPosition = Number(localStorage.getItem("scroll-position")) || 0;
    globalThis.scrollTo(0, scrollPosition);
    return () => {
      localStorage.setItem("scroll-position", globalThis.scrollY.toString());
    };
  }, []);
  return null;
};
