import { useEffect } from "preact/hooks";

export const Scroll = () => {
  useEffect(() => {
    const scrollPosition = Number(sessionStorage.getItem("scroll-position")) ||
      0;
    globalThis.scrollTo(0, scrollPosition);
    return () => {
      sessionStorage.setItem("scroll-position", globalThis.scrollY.toString());
    };
  }, []);
  return null;
};
